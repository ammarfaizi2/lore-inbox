Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276627AbRJCRqz>; Wed, 3 Oct 2001 13:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276630AbRJCRqp>; Wed, 3 Oct 2001 13:46:45 -0400
Received: from AMontpellier-201-1-2-24.abo.wanadoo.fr ([193.253.215.24]:39183
	"EHLO awak") by vger.kernel.org with ESMTP id <S276627AbRJCRqf> convert rfc822-to-8bit;
	Wed, 3 Oct 2001 13:46:35 -0400
Subject: Re: [POT] Which journalised filesystem ?
From: Xavier Bestel <xavier.bestel@free.fr>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20011003190315.G21866@emma1.emma.line.org>
In-Reply-To: <Pine.LNX.4.33L.0110030938130.4835-100000@imladris.rielhome.conectiva>
	<Pine.LNX.4.30.0110031448460.16788-100000@Appserv.suse.de> 
	<20011003190315.G21866@emma1.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.14.99+cvs.2001.09.27.21.30 (Preview Release)
Date: 03 Oct 2001 19:41:14 +0200
Message-Id: <1002130880.10919.0.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le mer 03-10-2001 at 19:03 Matthias Andree a écrit :
> On Wed, 03 Oct 2001, Dave Jones wrote:
> 
> > Alan mentioned this was something to do with the IBM hard disk
> > having strange write-cache properties that confuse ext3.
> 
> hdparm -W0 /dev/hda is your friend.

Unfortunately I think IDE drives don't honor this setting - write-cache
is always on.

	Xav

