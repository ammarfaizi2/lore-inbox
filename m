Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273918AbRJTSyK>; Sat, 20 Oct 2001 14:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273976AbRJTSyB>; Sat, 20 Oct 2001 14:54:01 -0400
Received: from ns-3.dglnet.com.br ([200.246.42.67]:43483 "HELO
	ns-3.dglnet.com.br") by vger.kernel.org with SMTP
	id <S273918AbRJTSxq>; Sat, 20 Oct 2001 14:53:46 -0400
Date: Sat, 20 Oct 2001 16:54:18 -0200
To: linux-kernel@vger.kernel.org
Subject: namei.c:642: warning: comparison is always false due to limited range of data type
Message-ID: <20011020165418.A21248@dglnet.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
From: edson@dglnet.com.br (Edson Y. Fugio)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I was compiling 2.4.12-ac3 on sparc20 (debian woody, gcc-2.95.4) and got this:
gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-
pointer -fno-strict-aliasing -fno-common -m32 -pipe -mno-fpu -fcall-used-g5 -fcall-used-g7    -c -o 
namei.o namei.c
namei.c: In function `reiserfs_mkdir':
namei.c:642: warning: comparison is always false due to limited range of data type
namei.c: In function `reiserfs_link':
namei.c:928: warning: comparison is always false due to limited range of data type
namei.c: In function `reiserfs_rename':
namei.c:1186: warning: comparison is always false due to limited range of data type

Regards,

Edson Fugio
