Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136568AbRAHS0S>; Mon, 8 Jan 2001 13:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137145AbRAHS0H>; Mon, 8 Jan 2001 13:26:07 -0500
Received: from c-025.static.AT.KPNQwest.net ([193.154.188.25]:59894 "EHLO
	stefan.sime.com") by vger.kernel.org with ESMTP id <S136568AbRAHSZy>;
	Mon, 8 Jan 2001 13:25:54 -0500
Date: Mon, 8 Jan 2001 19:24:55 +0100
From: Stefan Traby <stefan@hello-penguin.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Stefan Traby <stefan@hello-penguin.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ramfs problem... (unlink of sparse file in "D" state)
Message-ID: <20010108192455.A1891@stefan.sime.com>
Reply-To: Stefan Traby <stefan@hello-penguin.com>
In-Reply-To: <20010108191833.A1764@stefan.sime.com> <Pine.GSO.4.21.0101081320030.4061-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0101081320030.4061-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Mon, Jan 08, 2001 at 01:22:49PM -0500
Organization: Stefan Traby Services && Consulting
X-Operating-System: Linux 2.4.0-fijiji0 (i686)
X-APM: 100% 400 min
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2001 at 01:22:49PM -0500, Alexander Viro wrote:

> Here's another one: suppose that /foo is a mountpoint and you have
> no read permissions on it. Try to open the thing...

I would return EACCESS.
[EACCES]
          Search permission is denied for a component of the path prefix.
             


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
