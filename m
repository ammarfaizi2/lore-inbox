Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286343AbSASRyG>; Sat, 19 Jan 2002 12:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286413AbSASRx4>; Sat, 19 Jan 2002 12:53:56 -0500
Received: from 10fwd.cistron-office.nl ([195.64.65.197]:20744 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S286343AbSASRxn>; Sat, 19 Jan 2002 12:53:43 -0500
Date: Sat, 19 Jan 2002 18:53:42 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
Message-ID: <20020119185342.A27582@cistron.nl>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <miquels@cistron.nl> <200201191521.g0JFL1sv002752@tigger.cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201191521.g0JFL1sv002752@tigger.cs.uni-dortmund.de>; from brand@jupiter.cs.uni-dortmund.de on Sat, Jan 19, 2002 at 04:21:01PM +0100
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Horst von Brand:
> > I now have a flink-test2.txt file. That is pretty cool ;)
> 
> This is a possible security risk: The unlinking program thinks the file is
> forever inaccessible, but it isn't...

Why. If you keep an fd open to it it's accessible anyway, and if
you like you can copy it to a new file. Or you could link(2) it
beforehand, etc etc

Mike.
