Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVBGTA4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVBGTA4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:00:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVBGTAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:00:44 -0500
Received: from rproxy.gmail.com ([64.233.170.198]:56206 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261242AbVBGS7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 13:59:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ibpkWRFteN6dRl7irbRdjP9w6a1mkY0nWWhesCSxK3ZzOyr0anmrqpFpxLJfUl51plFXyi0OlXHWl+vvrD/wHD6EEHZvby9CXfHtQ/zZO0tGbfS0xv05Stqh817Ru0B2Ljomdhowsg7qz6St+6JtOZ3tSZjDlvpt4J5SZ0Co+HE=
Message-ID: <d120d50005020710591181fe69@mail.gmail.com>
Date: Mon, 7 Feb 2005 13:59:13 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: trelane@digitasaru.net, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org, petero2@telia.com
Subject: Re: [ATTN: Dmitry Torokhov] About the trackpad and 2.6.11-rc[23] but not -rc1
In-Reply-To: <20050207180950.GA12024@digitasaru.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050207154326.GA13539@digitasaru.net>
	 <d120d50005020708512bb09e0@mail.gmail.com>
	 <20050207180950.GA12024@digitasaru.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Feb 2005 12:09:50 -0600, Joseph Pingenot
<trelane@digitasaru.net> wrote:
> From Dmitry Torokhov on Monday, 07 February, 2005:
> >Nonetheless it would be nice to see the data stream from the touchpad
> >to see why our ALPS support does not work quite right. Could you
> >please try booting with "log_buf_len=131072 i8042.debug=1", and
> >working the touchpad a bit. then send me the output of "dmesg -s
> >131072" (or just /var/log/messages).
> 
> dmesg output, non-mouse output trimmed (for obvious reasons, if you think
>  about it ;) is attached.
> 

I am sorry, I was not clear enough. I'd like to see -rc2 (the broken
one), complete with bootup process, so we will see why it can't
synchronize at all. (I of course don't need keyboard data of anything
that has been typed after boot).

-- 
Dmitry
