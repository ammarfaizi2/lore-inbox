Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932174AbWFMQZT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932174AbWFMQZT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWFMQZT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:25:19 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:6874 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S932177AbWFMQZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:25:16 -0400
Date: Tue, 13 Jun 2006 13:25:12 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCSBRK(1) on pl2303 USB/serial returns prematurely
Message-ID: <20060613132512.3b7def2d@doriath.conectiva>
In-Reply-To: <20060612145750.GA19338@kestrel.barix.local>
References: <20060612145750.GA19338@kestrel.barix.local>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.3 (GTK+ 2.9.2; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Karel,

On Mon, 12 Jun 2006 16:57:50 +0200
Karel Kulhavy <clock@twibright.com> wrote:

| Hello
| 
| TCSBRK(1) ioctl system call on pl2303 USB/serial converter on 2.6.16.19
| returns prematurely. Additional 53ms delay is necessary to work this
| around at speed of 57600. TCSBRK(1) is translation of the tcdrain()
| function by glibc. With ordinary serial port the TCSBRK(1) seems to work
| correctly.

 If you have some time to spend on it, could you please try the
patches at:

http://distro2.conectiva.com.br/~lcapitulino/patches/usbserial/2.6.17-rc5/serialcore-port-V0/


-- 
Luiz Fernando N. Capitulino
