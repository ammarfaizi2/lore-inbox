Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265453AbSIRGaK>; Wed, 18 Sep 2002 02:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSIRGaK>; Wed, 18 Sep 2002 02:30:10 -0400
Received: from relay1.pair.com ([209.68.1.20]:40969 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S265453AbSIRGaJ>;
	Wed, 18 Sep 2002 02:30:09 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3D88208E.8545AAA2@kegel.com>
Date: Tue, 17 Sep 2002 23:43:26 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Hardware limits on numbers of threads?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://people.redhat.com/drepper/glibcthreads.html says:

> Hardware restrictions put hard limits on the number of 
> threads the kernel can support for each process. 
> Specifically this applies to IA-32 (and AMD x86_64) where the thread
> register is a segment register. The processor architecture 
> puts an upper limit on the number of segment register values 
> which can be used (8192 in this case).

Is this true?  Where does the limit come from?
- Dan
