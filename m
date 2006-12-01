Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162338AbWLAXdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162338AbWLAXdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:33:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162345AbWLAXcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:32:55 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:48845 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1162273AbWLAXcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:32:52 -0500
Date: Fri, 1 Dec 2006 15:32:47 -0800
From: thockin@hockin.org
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Sebastian Kemper <sebastian_ml@gmx.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OHCI] BIOS handoff failed (BIOS bug?)
Message-ID: <20061201233247.GA27014@hockin.org>
References: <20061201130359.GA3999@section_eight> <20061201182855.GA7867@section_eight> <20061201150201.4e8c9edb.zaitcev@redhat.com> <20061201232339.GA25645@hockin.org> <20061201152922.93cc59a4.zaitcev@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201152922.93cc59a4.zaitcev@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2006 at 03:29:22PM -0800, Pete Zaitcev wrote:
> On Fri, 1 Dec 2006 15:23:39 -0800, thockin@hockin.org wrote:
> 
> > BIOS handoff assumes an SMI, right?  Could SMI be masked?
> 
> That might be a bad idea, because things like fans may be controlled
> by SMM BIOS. The best thing we can do is to follow the published
> procedure, and maybe insert a workaround if Sebastian can identify it.

Sorry, I don't mean "could we mask it" but rather "is it possible that it
is already masked"?

Tim
