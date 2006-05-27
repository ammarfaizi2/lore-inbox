Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWE0VKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWE0VKV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 May 2006 17:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWE0VKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 May 2006 17:10:21 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:31158 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964979AbWE0VKT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 May 2006 17:10:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WF8DuExyuJ2W9WHspxHmItIw1JQPmvgRcnHFMxWohE4xsTL3nvyhbda+QkGMeHEMgx3jg/WFPikkedONIQ46Y+J4az2s8GsmgKYyrgqHbq5iBEjmKw9wzpGpZ9r7y1LSTK20pzXMTotRBSrrw6emLAHTYyHSIltnIuNnRyMIJSU=
Message-ID: <4807377b0605271410j39532f44j2cafd3239d40bf31@mail.gmail.com>
Date: Sat, 27 May 2006 14:10:17 -0700
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Aravind Gottipati" <aravind@freeshell.org>
Subject: Re: e1000 poor network performance - 2.6.17-rc5-g705af309
Cc: linux-kernel@vger.kernel.org, "NetDEV list" <netdev@vger.kernel.org>
In-Reply-To: <20060526212243.GA19250@SDF.LONESTAR.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060526212243.GA19250@SDF.LONESTAR.ORG>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/06, Aravind Gottipati <aravind@freeshell.org> wrote:
> Hi,
>
> I recently started running linux on a new x60 thinkpad and started
> noticing really poor network performance with this kernel.  I saw some
> archived threads from a while back saying this could be related to
> conntracking.  Disabled that (rmmod ip_conntrack) did not fix the
> problem.  I also tried disabling tso but that didn't have any effect
> either.  I can reproduce the problem when connected to a 100Mbps switch
> (I don't have a GigE network to test this with).

First, lets move this over to netdev (see CC)

> This laptop uses the Intel 82573L (PCI-Express) chip.  I'd be glad to
> assist with any toubleshooting/testing w.r.t this.  I am not subscribed
> to the list, so please cc me on any replies.

What kind of poor performance?  what test? please send the output of
ethtool -e ethX and ethtool -S ethX after you've been having problems.

please provide more details and we can see if we can help.

Jesse
