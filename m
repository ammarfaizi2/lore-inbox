Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276836AbRJCCU7>; Tue, 2 Oct 2001 22:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276837AbRJCCUt>; Tue, 2 Oct 2001 22:20:49 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:37146 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S276836AbRJCCUi>; Tue, 2 Oct 2001 22:20:38 -0400
Subject: Re: [PATCH] Intel 830 support for agpgart
From: Robert Love <rml@tech9.net>
To: David Weinehall <tao@acc.umu.se>
Cc: Christof Efkemann <efkemann@uni-bremen.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20011003021658.O7800@khan.acc.umu.se>
In-Reply-To: <20011002033227.6e047544.efkemann@uni-bremen.de>
	<1001988137.2780.53.camel@phantasy>
	<20011002151051.488306ee.efkemann@uni-bremen.de>
	<1002066345.1003.66.camel@phantasy>  <20011003021658.O7800@khan.acc.umu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14.99+cvs.2001.09.30.08.08 (Preview Release)
Date: 02 Oct 2001 22:20:43 -0400
Message-Id: <1002075650.1237.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-02 at 20:16, David Weinehall wrote:
> If the only differences between the different cards are the nr of
> aperture-sizes and the status-register settings, why not have a struct
> which contains all the valid cards, and use a scan-routine?!

I suppose we could, and this is a good idea -- although we'd be
reapproaching the size of the current implementation which would be
theoretically faster, too.

There are only 3 possibilities right now (i830, i840, and everything
else).

Hmm, maybe I will code this nonetheless...

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

