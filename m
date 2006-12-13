Return-Path: <linux-kernel-owner+w=401wt.eu-S1750730AbWLMU30@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWLMU30 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 15:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbWLMU30
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 15:29:26 -0500
Received: from codepoet.org ([166.70.99.138]:40615 "EHLO codepoet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732AbWLMU30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 15:29:26 -0500
Date: Wed, 13 Dec 2006 13:29:25 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Karsten Weiss <K.Weiss@science-computing.de>
Cc: Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory hole mapping related bug?!
Message-ID: <20061213202925.GA3909@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Karsten Weiss <K.Weiss@science-computing.de>,
	Christoph Anton Mitterer <calestyo@scientia.net>,
	linux-kernel@vger.kernel.org, Chris Wedgwood <cw@f00f.org>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet> <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Dec 11, 2006 at 10:24:02AM +0100, Karsten Weiss wrote:
> We could not reproduce the data corruption anymore if we boot
> the machines with the kernel parameter "iommu=soft" i.e. if we
> use software bounce buffering instead of the hw-iommu.

I just realized that booting with "iommu=soft" makes my pcHDTV
HD5500 DVB cards not work.  Time to go back to disabling the
memhole and losing 1 GB.  :-(

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
