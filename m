Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280291AbRKKU0G>; Sun, 11 Nov 2001 15:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280531AbRKKUZ5>; Sun, 11 Nov 2001 15:25:57 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:39411 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S280291AbRKKUZh>; Sun, 11 Nov 2001 15:25:37 -0500
Date: Sun, 11 Nov 2001 21:25:27 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: "Paulo J. Matos aka PDestroy" <pocm@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compiling manually
Message-ID: <20011111212527.C773@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <m3k7wxkzy2.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <m3k7wxkzy2.fsf@localhost.localdomain>; from pocm@rnl.ist.utl.pt on Sun, Nov 11, 2001 at 04:57:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 04:57:41PM +0000, Paulo J. Matos aka PDestroy wrote:
> How can I remove optimization from that file only or maybe
> compile the file manually and then don't let make compile the
> file again?

CFLAGS_$(your_target_file) := -O0 

or

CFLAGS_$(your_target_file) := -O1 

should do, what you want.

Regards

Ingo Oeser
-- 
In der Wunschphantasie vieler Mann-Typen [ist die Frau] unsigned und
operatorvertraeglich. --- Dietz Proepper in dasr
