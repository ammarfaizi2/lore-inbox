Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290797AbSDVOcj>; Mon, 22 Apr 2002 10:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293135AbSDVOci>; Mon, 22 Apr 2002 10:32:38 -0400
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:2534 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S290797AbSDVOch>; Mon, 22 Apr 2002 10:32:37 -0400
To: linux-kernel@vger.kernel.org
Subject: [SECURITY] FDs 0, 1, 2 for SUID/SGID programs
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Mon, 22 Apr 2002 16:31:52 +0200
Message-ID: <87662jiz3b.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://www.pine.nl/advisories/pine-cert-20020401.html probably affects
Linux, too (if a SUID/SGID program is invoked with FD 2 closed, error
messages might be written to a file opened by the program ).

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
