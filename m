Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316532AbSGAVmo>; Mon, 1 Jul 2002 17:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316535AbSGAVmn>; Mon, 1 Jul 2002 17:42:43 -0400
Received: from mail-infomine.ucr.edu ([138.23.89.48]:10956 "EHLO
	mail-infomine.ucr.edu") by vger.kernel.org with ESMTP
	id <S316532AbSGAVmm>; Mon, 1 Jul 2002 17:42:42 -0400
Date: Mon, 1 Jul 2002 14:45:07 -0700
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Diff b/w 32bit & 64-bit
Message-ID: <20020701214507.GA21541@mail-infomine.ucr.edu>
References: <5F0021EEA434D511BE7300D0B7B6AB5303C78735@mail2.ggn.hcltech.com> <yw1xpty71bea.fsf@gladiusit.e.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xpty71bea.fsf@gladiusit.e.kth.se>
User-Agent: Mutt/1.3.28i
X-Fnord: +++ath
X-WebTV-Stationery: Standard; BGColor=black; TextColor=black
X-Message-Flag: Message text blocked: ADULT LANGUAGE/SITUATIONS
X-BeenThere: crackmonkey@crackmonkey.org
From: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach M?ns Rullg?rd:
> "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com> writes:
> 
> > Hello All
> >  I am working on a Driver.
> > Considering the processor 2 B Intel's x86, 
> > can some one enlighten me with the differences of Linux on a 64-bit
> > processor & a 32-Bit processor.
> 
> For Alpha: sizeof(int) == 4, sizeof(long) == 8, sizeof(void *) == 8
> For intel: sizeof(int) == 4, sizeof(long) == 4, sizeof(void *) == 8
                                                  ^^^^^^^^^^^^^^^^^^^
I don't know where you come up with that.  On x86 Linux the size of
any pointer is 4 bytes!
> 
> The most common mistake is trying to stuff a pointer into an
> int. Don't do that.
> 
> -- 
> M?ns Rullg?rd
> mru@users.sf.net
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Johannes
--
Dr. Johannes Ruscheinski
EMail:    ruschein_AT_infomine.ucr.edu ***          Linux                  ***
Location: science library, room G40    *** The Choice Of A GNU Generation! ***
Phone:    (909) 787-2279

"Faith may be defined briefly as an illogical belief in the occurrence of the improbable...
 A man full of faith is simply one who has lost (or never had) the capacity for clear and
 realistic thought. He is not a mere ass: he is actually ill."
               -- H. L. Mencken
