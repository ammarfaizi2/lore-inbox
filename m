Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271821AbRHXPII>; Fri, 24 Aug 2001 11:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272114AbRHXPH6>; Fri, 24 Aug 2001 11:07:58 -0400
Received: from relay01.cablecom.net ([62.2.33.101]:39438 "EHLO
	relay01.cablecom.net") by vger.kernel.org with ESMTP
	id <S271821AbRHXPHy>; Fri, 24 Aug 2001 11:07:54 -0400
Message-Id: <200108241508.f7OF89k14834@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: creating new directories under /proc
Date: Fri, 24 Aug 2001 17:08:01 +0200
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to create a new file in the proc file system i can use 
create_proc_read_entry("/proc/driver/my_new_file", 0, 0, my_proc, 0)

but what if i want to register my_new_file under a directory
/proc/driver/my_driver_dir/. how do i create a new directory under
the proc tree?
