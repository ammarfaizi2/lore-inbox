Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292382AbSBYW7f>; Mon, 25 Feb 2002 17:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292386AbSBYW70>; Mon, 25 Feb 2002 17:59:26 -0500
Received: from AGrenoble-101-1-7-138.abo.wanadoo.fr ([80.13.189.138]:43664
	"EHLO lyon.ram.loc") by vger.kernel.org with ESMTP
	id <S292382AbSBYW7W>; Mon, 25 Feb 2002 17:59:22 -0500
To: linux-kernel@vger.kernel.org
From: Raphael_Manfredi@pobox.com (Raphael Manfredi)
Subject: Re: setsockopt(SOL_SOCKET, SO_SNDBUF) broken on 2.4.18?
Date: 25 Feb 2002 22:19:42 GMT
Organization: Home, Grenoble, France
Message-ID: <a5ed9u$3tp$1@lyon.ram.loc>
In-Reply-To: <2871.1014671286@nice.ram.loc> <Pine.LNX.3.95.1020225163035.29043C-100000@chaos.analogic.com>
X-Newsreader: trn 4.0-test74 (May 26, 2000)
In-Reply-To: <Pine.LNX.3.95.1020225163035.29043C-100000@chaos.analogic.com>
X-Mailer: newsgate 1.0 at lyon.ram.loc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting root@chaos.analogic.com from ml.linux.kernel:
:This came up a few months ago. Don't halve the size. The value was
:explained to NOT be a bug even though it doesn't make sense to us
:mortals. Just set the buffer size without reading anything. It will
:be fine. The explaination was somewhat smokey, but It seems as though
:two buffers are set aside or something like that. Just don't read
:the size. Set it and forget it.

The problem is that I don't want to shrink the buffer size, hence I need
to read the current size.  Do I need to halve the returned value from
getsockopt() then?

Raphael
