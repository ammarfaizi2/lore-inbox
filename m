Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289034AbSAIVvS>; Wed, 9 Jan 2002 16:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289033AbSAIVvI>; Wed, 9 Jan 2002 16:51:08 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:14347 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289036AbSAIVu7>; Wed, 9 Jan 2002 16:50:59 -0500
Date: Wed, 9 Jan 2002 22:50:54 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Simple local DOS
Message-ID: <20020109215054.GB15080@emma1.emma.line.org>
Reply-To: nonexistent@localhost.emma.line.org
Mail-Followup-To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <3C3C74F7.FE41CD0E@uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3C3C74F7.FE41CD0E@uni-mb.si>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Jan 2002, David Balazic wrote:

> 
> log in on some virtual terminal, then run the following line
> in a bourne type shell, like bash :
> 
> X 2>&1 | less
> 
> A reboot "fixes" it. We want to reach windows level quality on desktop
> after all, don't we ?

You can also fix that by a remote login, chvt, or by just not piping X
output into interactive programs. tail -f is a viable workaround -- and
all this is off-topic on linux-kernel, it's your own dumbness that makes
you do these things. Better run kdm, gdm or xdm or something and you're
not having this problem.
