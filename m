Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265887AbRGEQEX>; Thu, 5 Jul 2001 12:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265895AbRGEQEM>; Thu, 5 Jul 2001 12:04:12 -0400
Received: from h24-78-188-202.vn.shawcable.net ([24.78.188.202]:32786 "EHLO
	cs206465-b.nvcr1.bc.wave.home.com") by vger.kernel.org with ESMTP
	id <S265887AbRGEQEG>; Thu, 5 Jul 2001 12:04:06 -0400
Message-ID: <3B449096.10CB3F79@linisoft.com>
Date: Thu, 05 Jul 2001 09:06:46 -0700
From: Reza Roboubi <reza@linisoft.com>
Organization: Linisoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Naveen Kumar Pagidimarri <naveen.pagidimarri@wipro.com>,
        linux-kernel@vger.kernel.org
Subject: Re: code of ps command
In-Reply-To: <GFZZVD00.2E5@vindhya.mail.wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen Kumar Pagidimarri wrote:

>         tell me the source where i can get the information about the
>
>
>       data structures/related system calls used for the
>
>   implementation of the ps command.

The ps command probably reads ALL or most of the info it needs from the /proc
directory.  The proc filesystem is a virtual filesystem implemented by the
kernel.

