Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWEMLHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWEMLHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932369AbWEMLHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:07:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27071 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932328AbWEMLHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:07:14 -0400
Subject: Re: Executable shell scripts
From: Arjan van de Ven <arjan@infradead.org>
To: Mark Rosenstand <mark@borkware.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060513110324.10A38146AF@hunin.borkware.net>
References: <20060513103841.B6683146AF@hunin.borkware.net>
	 <1147517786.3217.0.camel@laptopd505.fenrus.org>
	 <20060513110324.10A38146AF@hunin.borkware.net>
Content-Type: text/plain
Date: Sat, 13 May 2006 13:07:12 +0200
Message-Id: <1147518432.3217.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-13 at 13:03 +0200, Mark Rosenstand wrote:
> Arjan van de Ven <arjan@infradead.org> wrote:
> > On Sat, 2006-05-13 at 12:38 +0200, Mark Rosenstand wrote:
> > > Hi,
> > > 
> > > Is it in any (reasonable) way possible to make Linux support executable
> > > shell scripts? Perhaps through binfmt_misc?
> > 
> > ehhhhhh this is already supposed to work.
> 
> It doesn't:
> 
> bash-3.00$ cat << EOF > test
> > #!/bin/sh
> > echo "yay, I'm executing!"
> > EOF
> bash-3.00$ chmod 111 test
> bash-3.00$ ./test
> /bin/sh: ./test: Permission denied

is your script readable as well? 111 is just weird/odd.


