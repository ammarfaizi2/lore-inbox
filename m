Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbWDUHW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWDUHW5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 03:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWDUHW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 03:22:57 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:3480 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751255AbWDUHW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 03:22:56 -0400
Date: Fri, 21 Apr 2006 03:22:54 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Daniel Walker <dwalker@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
In-Reply-To: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
Message-ID: <Pine.LNX.4.64.0604210322110.21429@d.namei>
References: <200604210703.k3L73VZ6019794@dwalker1.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2006, Daniel Walker wrote:

> 	I included a patch , not like it's needed . Recently I've been
> evaluating likely/unlikely branch prediction .. One thing that I found 
> is that the kfree function is often called with a NULL "objp" . In fact
> it's so frequent that the "unlikely" branch predictor should be inverted!
> Or at least on my configuration. 

It would be helpful to collect some stats on this so we can look at the 
ratio.


- James
-- 
James Morris
<jmorris@namei.org>
