Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315419AbSELUqe>; Sun, 12 May 2002 16:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315421AbSELUqd>; Sun, 12 May 2002 16:46:33 -0400
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:34218 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S315419AbSELUqd>; Sun, 12 May 2002 16:46:33 -0400
To: linux-kernel@vger.kernel.org
Subject: swap_dup/swap_free: Bad swap file entry
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Sun, 12 May 2002 22:45:44 +0200
Message-ID: <87held2iyv.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What do these messages mean?  That something is terribly hosed?

swap_dup: Bad swap file entry 1842b040
VM: killing process cc1
swap_free: Bad swap file entry 1dab3064
swap_free: Bad swap file entry 1842b040
swap_free: Bad swap file entry 18429040
swap_free: Bad swap file entry 31d7303c
swap_free: Bad swap offset entry 31d71000

(This is from a UP 2.4.18 kernel with XFS 1.1 patches.)

Is this caused by a hardware defect (broken IDE interface, maybe; in
our case VIA vt8233)?

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
