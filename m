Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTFGA1t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTFGA1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:27:49 -0400
Received: from smtp3.brturbo.com ([200.199.201.47]:27869 "EHLO
	smtp.brturbo.com") by vger.kernel.org with ESMTP id S262422AbTFGA1s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:27:48 -0400
Message-ID: <24125709.1054946013743.JavaMail.nobody@webmail2>
Date: Fri, 6 Jun 2003 21:33:33 -0300 (BRT)
From: <marcelopenna@brturbo.com>
To: linux-kernel@vger.kernel.org
Subject: Getting nvnet to work with 2.5.x kernel
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=18444693.1054946013741.JavaMail.nobody.webmail2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--18444693.1054946013741.JavaMail.nobody.webmail2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I=B4m trying to get nvnet (NVidia=B4s closed source ethernet driver) to wor=
k with 2.5.70 kernel. I got it to compile, but when I try to load it I get =
an error message "module format invalid". By comparing the output of readel=
f -r of it with other modules, I noticed that it=B4s missing the following:

Relocation section '.rel.gnu.linkonce.this_module' at offset 0x9ac contains=
 2 entries:
 Offset     Info    Type            Sym.Value  Sym. Name
00000068  00002501 R_386_32          00000090   init_module
0000010c  00002101 R_386_32          00000000   cleanup_module

I think that it may be the problem, but I really don=B4t have a clue on how=
 to include these two.

Any help would be great.

Thank you,
Marcelo Penna Guerra
--18444693.1054946013741.JavaMail.nobody.webmail2--

