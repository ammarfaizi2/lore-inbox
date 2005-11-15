Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751003AbVKOVgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbVKOVgU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 16:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVKOVgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 16:36:20 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:5023 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750985AbVKOVgU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 16:36:20 -0500
Message-ID: <437A5568.5040602@us.ibm.com>
Date: Tue, 15 Nov 2005 15:38:48 -0600
From: "V. Ananda Krishnan" <mansarov@us.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: tty_flip_buffer 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In the new tty_buffer structure, flag_buf_ptr is used in addition to the 
char_buf_ptr.  Is this flag_buf_ptr used as an additional buffer to 
extend the character buffer during the use of 
tty_insert_flip_string_flags() API?  When I looked into the 
implementation of the tty_insert_flip_string_flags API in tty_io.c, I 
was little confused.


Also, can any one explain me the function of the free queue head in the 
struct tty_bufhead?

Thanks,
Ananda

V. ANANDA KRISHNAN

