Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136294AbRAHSDQ>; Mon, 8 Jan 2001 13:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136271AbRAHSCz>; Mon, 8 Jan 2001 13:02:55 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:57334 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S136198AbRAHSCn>;
	Mon, 8 Jan 2001 13:02:43 -0500
Date: Mon, 8 Jan 2001 17:22:25 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stefan@hello-penguin.com, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010108172225.A1391@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010108165541.A1186@stefan.sime.com> <E14FejQ-0004pW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14FejQ-0004pW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 08, 2001 at 04:01:10PM +0000
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 04:01:10PM +0000, Alan Cox wrote:
> > I prefer SuS fpathconf(), pathconf() is just a wrapper to fpathconf();
> 
> You can't implement it that way in the corner cases.

I reread SuSv2 again and didn't found corner cases.
Do you mean FIFO/pipe stuff ? I can't see the problem in this area.

In which case is an emulation of pathconf by fpathconf impossible ?

-- 

  ciao - 
    Stefan

"     ( cd /lib ; ln -s libBrokenLocale-2.2.so libNiedersachsen.so )     "
    
Stefan Traby                Linux/ia32               fax:  +43-3133-6107-9
Mitterlasznitzstr. 13       Linux/alpha            phone:  +43-3133-6107-2
8302 Nestelbach             Linux/sparc       http://www.hello-penguin.com
Austria                                    mailto://st.traby@opengroup.org
Europe                                   mailto://stefan@hello-penguin.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
