Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262263AbRENQwG>; Mon, 14 May 2001 12:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262260AbRENQv5>; Mon, 14 May 2001 12:51:57 -0400
Received: from t2.redhat.com ([199.183.24.243]:14326 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262263AbRENQvo>; Mon, 14 May 2001 12:51:44 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <m1k83kj7dj.fsf@frodo.biederman.org> 
In-Reply-To: <m1k83kj7dj.fsf@frodo.biederman.org>  <m1y9s1jbml.fsf@frodo.biederman.org> <20010511162412.A11896@lucon.org> <15100.30085.5209.499946@pizda.ninka.net> <20010511165339.A12289@lucon.org> <m13da9ky7s.fsf@frodo.biederman.org> <20010513110707.A11055@lucon.org> <16874.989832587@redhat.com> 
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: "H . J . Lu" <hjl@lucon.org>, "David S. Miller" <davem@redhat.com>,
        alan@lxorguk.ukuu.org.uk, linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Enable IP PNP for 2.4.4-ac8 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 14 May 2001 17:51:19 +0100
Message-ID: <8717.989859079@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ebiederm@xmission.com said:
>  There wasn't even DHCP support before so yes you did.   As you can't
> get the nfs mount point from bootp. 

Wasn't there a default? The Indy behind me seems to try to mount
/tftpboot/172.16.18.195, so I put a filesystem there just to make it happy.

It's a 2.4.3 kernel.

>  Well I think in the CONFIG_BLK_DEV=n case it might wind up being a
> ramfs or tmpfs image.  Something like a simplified version of tar. 

Well, if it stops working and stays broken, I suppose I'll just have to 
hack up a built-in command line option. ISTR ARM already has such an option.

I'd rather it didn't break, though.


--
dwmw2


