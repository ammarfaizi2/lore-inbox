Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265024AbRGQBDn>; Mon, 16 Jul 2001 21:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbRGQBDd>; Mon, 16 Jul 2001 21:03:33 -0400
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:16982 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S265024AbRGQBDS>; Mon, 16 Jul 2001 21:03:18 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: samandbuffy@yahoo.com
cc: "Victoria W." <wicki@terror.de>, linux-kernel@vger.kernel.org,
        volker@erste.de
Subject: Re: send_sig_info help? 
In-Reply-To: Your message of "Mon, 16 Jul 2001 09:45:46 MST."
             <20010716164546.55938.qmail@web13903.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Jul 2001 11:01:25 +1000
Message-ID: <902.995331685@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001 09:45:46 -0700 (PDT), 
<samandbuffy@yahoo.com> wrote:
>The problem I'm experiencing is that I'm not sure how
>to find the pointer to taskstruct.  From what I"ve
>read, the pointer to taskstruct is a pointer to the
>target process.  How do I find the pointer to the
>taskstruct of that task I want to send a signal to, if
>I only know its PID?

See drivers/char/sysrq.c::send_sig_all().

