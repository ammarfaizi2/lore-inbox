Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbSLLJ7J>; Thu, 12 Dec 2002 04:59:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267450AbSLLJ7J>; Thu, 12 Dec 2002 04:59:09 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:29422 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S265700AbSLLJ7J>; Thu, 12 Dec 2002 04:59:09 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Arjan van de Ven <arjanv@redhat.com>
To: Terje Eggestad <terje.eggestad@scali.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@codemonkey.org.uk>
In-Reply-To: <1039686176.25186.195.camel@pc-16.office.scali.no>
References: <1039610907.25187.190.camel@pc-16.office.scali.no>
	<3DF78911.5090107@zytor.com> 
	<1039686176.25186.195.camel@pc-16.office.scali.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Dec 2002 11:06:49 +0100
Message-Id: <1039687609.1450.2.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-12 at 10:42, Terje Eggestad wrote:

> It takes about 11 cycles on athlon, 34 on PII, and a whooping 84 on P4.
> 
> For a simple op like that, even 11 is a lot... Really makes you wonder.

wasn't rdtsc also supposed to be a pipeline sync of the cpu?
(or am I confusing it with cpuid)
