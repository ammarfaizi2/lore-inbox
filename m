Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272360AbTGaAAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 20:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272359AbTGaAAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 20:00:53 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:37385 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S272360AbTGaAAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 20:00:50 -0400
Date: Thu, 31 Jul 2003 10:00:37 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Richard A Nelson <cowboy@vnet.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-mm1 & ipsec-tools (xfrm_type_2_50?)
In-Reply-To: <Pine.LNX.4.56.0307301515250.26621@onqynaqf.yrkvatgba.voz.pbz>
Message-ID: <Mutt.LNX.4.44.0307310959390.20194-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jul 2003, Richard A Nelson wrote:

> most of the module not found messages are fine, its xfrm_type_2_50 that
> I'm worried about... What am I missing ?

Possibly some aliases in /etc/modprobe.conf

alias xfrm-type-2-50    esp4
alias xfrm-type-2-51    ah4
alias xfrm-type-2-108   ipcomp
alias xfrm-type-10-50   esp6
alias xfrm-type-10-51   ah6
alias xfrm-type-10-108  ipcomp6


- James
-- 
James Morris
<jmorris@intercode.com.au>

