Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUCOUi4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 15:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUCOUi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 15:38:56 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:21002 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S262744AbUCOUiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 15:38:55 -0500
Date: Mon, 15 Mar 2004 15:38:53 -0500
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: 2.6.4 sunrpc oops.
Message-ID: <20040315203853.GF3114@fieldses.org>
References: <20040315194642.GB19555@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040315194642.GB19555@redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 07:46:42PM +0000, Dave Jones wrote:
> modprobe auth_rpcgss
> rmmod auth_rpcgss
> rmmod sunrpc
> *bang*
> 
> Seems to survive rmmod sunrpc usually, so it's the auth_rpcgcc
> module leaving something around long after its dead perhaps?

Yes, this is my fault, apologies.  I'll follow up with a patch as soon
as I've made one....--Bruce Fields
