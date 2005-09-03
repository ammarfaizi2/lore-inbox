Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161079AbVICAQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161079AbVICAQy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 20:16:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbVICAQy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 20:16:54 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:39343 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1161067AbVICAQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 20:16:53 -0400
Date: Fri, 2 Sep 2005 17:16:28 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Andi Kleen <ak@suse.de>
Cc: linux clustering <linux-cluster@redhat.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
Message-ID: <20050903001628.GH21228@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050901104620.GA22482@redhat.com> <20050901035939.435768f3.akpm@osdl.org> <1125586158.15768.42.camel@localhost.localdomain> <20050901132104.2d643ccd.akpm@osdl.org> <p73fysnqiej.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73fysnqiej.fsf@verdi.suse.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 11:17:08PM +0200, Andi Kleen wrote:
> The only thing that should be probably resolved is a common API
> for at least the clustered lock manager. Having multiple
> incompatible user space APIs for that would be sad.
As far as userspace dlm apis go, dlmfs already abstracts away a large part
of the dlm interaction, so writing a module against another dlm looks like
it wouldn't be too bad (startup of a lockspace is probably the most
difficult part there).
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
