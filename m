Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbVKBQVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbVKBQVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 11:21:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbVKBQVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 11:21:38 -0500
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:11402 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S965109AbVKBQVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 11:21:37 -0500
Date: Wed, 2 Nov 2005 11:21:36 -0500
To: Vladimir Lazarenko <vlad@lazarenko.net>
Cc: Dave Jones <davej@redhat.com>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Message-ID: <20051102162136.GB9488@csclub.uwaterloo.ca>
References: <1130445194.5416.3.camel@blade> <52mzkuwuzg.fsf@cisco.com> <20051027204923.M89071@linuxwireless.org> <1130446667.5416.14.camel@blade> <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade> <20051027211203.M33358@linuxwireless.org> <20051027220533.GA18773@redhat.com> <43615015.7090308@lazarenko.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43615015.7090308@lazarenko.net>
User-Agent: Mutt/1.5.9i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 12:09:25AM +0200, Vladimir Lazarenko wrote:
> I have Tyan k8e which supports memory remapping. Question, however, will 
> that work with i686-based kernel? Or do we have to switch to x86_64?

I suspect with PAE it will still work yes.  I haven't tried it of course
(I don't have that much ram).  It will still have the PAE performance
hit on memory access to memory past 4GB just because that's what PAE
does.

Len Sorensen
