Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310795AbSCHK0V>; Fri, 8 Mar 2002 05:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310797AbSCHK0L>; Fri, 8 Mar 2002 05:26:11 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:13552 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S310795AbSCHKZ6>; Fri, 8 Mar 2002 05:25:58 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020308094918.A16358@flint.arm.linux.org.uk> 
In-Reply-To: <20020308094918.A16358@flint.arm.linux.org.uk>  <11E89240C407D311958800A0C9ACF7D13A76E4@EXCHANGE> 
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ed Vance <EdV@macrolink.com>, "'Bill Nottingham'" <notting@redhat.com>,
        "'linux-serial'" <linux-serial@vger.kernel.org>,
        "'linux-kernel'" <linux-kernel@vger.kernel.org>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial.c procfs kudzu - discussion 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Mar 2002 10:25:47 +0000
Message-ID: <7997.1015583147@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rmk@arm.linux.org.uk said:
>  I think there are two bugs here that need treating in different ways.
> 

Don't forget the fact that non-existent ports are visible, you can open 
their device nodes, etc. That's just screwed. 

--
dwmw2


