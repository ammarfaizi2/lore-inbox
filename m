Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262145AbSJSUGs>; Sat, 19 Oct 2002 16:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265260AbSJSUGs>; Sat, 19 Oct 2002 16:06:48 -0400
Received: from kraid.nerim.net ([62.4.16.95]:43272 "EHLO kraid.nerim.net")
	by vger.kernel.org with ESMTP id <S262145AbSJSUGs>;
	Sat, 19 Oct 2002 16:06:48 -0400
Date: Sat, 19 Oct 2002 22:16:44 +0200
From: Jean Delvare <khali@linux-fr.org>
To: linux-kernel@vger.kernel.org
Subject: memory and /dev/mem
Message-Id: <20021019221644.58a51ede.khali@linux-fr.org>
Organization: http://www.linux-fr.org/
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi everyone,

I have a question about /dev/mem. It looks like /dev/mem is actually
shorter that the actual physical memory available on the system, by
about 600 kilobytes (seems to depend on the total size). Is there a
reason for that? It happens that on some systems, the DMI table is
located near the end of the memory, so we are not able to access it. Is
this memory area special?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
