Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSIAJPG>; Sun, 1 Sep 2002 05:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316599AbSIAJPG>; Sun, 1 Sep 2002 05:15:06 -0400
Received: from pizda.ninka.net ([216.101.162.242]:14529 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316595AbSIAJPF>;
	Sun, 1 Sep 2002 05:15:05 -0400
Date: Sun, 01 Sep 2002 02:13:08 -0700 (PDT)
Message-Id: <20020901.021308.66278765.davem@redhat.com>
To: R.E.Wolff@BitWizard.nl
Cc: alessandro.suardi@oracle.com, bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: drivers/atm/firestream.c doesn't compile in 2.5.33
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020901111433.A23165@bitwizard.nl>
References: <Pine.NEB.4.44.0209010227250.147-100000@mimas.fachschaften.tu-muenchen.de>
	<3D716D23.1000101@oracle.com>
	<20020901111433.A23165@bitwizard.nl>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
   Date: Sun, 1 Sep 2002 11:14:33 +0200
   
   Or did the __FUNCTION__ extension from gcc change? Someone please
   explain.....

CPP pasting __FUNCTION__ is now deprecated because for c++ you
cannot do it at compile time.   At least that is how I understand
the problem.

The long and short of it is that __FUNCTION__ cpp string pasting
is now illegal.

