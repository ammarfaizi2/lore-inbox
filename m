Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932394AbWEMLjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbWEMLjA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWEMLjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:39:00 -0400
Received: from mserv2.uoregon.edu ([128.223.142.41]:12993 "EHLO
	smtp.uoregon.edu") by vger.kernel.org with ESMTP id S932394AbWEMLi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:38:59 -0400
Message-ID: <4465C508.6050201@uoregon.edu>
Date: Sat, 13 May 2006 04:37:44 -0700
From: Joel Jaeggli <joelja@uoregon.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mark Rosenstand <mark@borkware.net>
CC: Douglas McNaught <doug@mcnaught.org>, arjan@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
References: <20060513103841.B6683146AF@hunin.borkware.net>	<1147517786.3217.0.camel@laptopd505.fenrus.org>	<20060513110324.10A38146AF@hunin.borkware.net>	<1147518432.3217.2.camel@laptopd505.fenrus.org>	<87r72yi346.fsf@suzuka.mcnaught.org> <20060513112754.1CA99146AF@hunin.borkware.net>
In-Reply-To: <20060513112754.1CA99146AF@hunin.borkware.net>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Rosenstand wrote:
> Douglas McNaught <doug@mcnaught.org> wrote:
>> It needs to be readable as well.  What ends up happening is that the
>> kernel sees the execute bit, looks at the shebang line and then does:
>>
>> /bin/sh test
>>
>> Since read permission is off, the shell's open() call fails.  It will
>> work fine if you use 755 as the permissions.
>>
>> Every Unix I've ever seen works this way.  It'd be nice to have
>> unreadable executable scripts, but no one's ever done it.
> 
> According to
> http://www.faqs.org/faqs/unix-faq/faq/part4/section-7.html both 4.3BSD
> and SunOS have. I can confirm that it works on current BSD's as
> well.

The faq you're refering to is 10-12 years old. 4.3BSD isn't relevant to
anyone beyond historians at this point.

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


-- 
-------------------------------------------------
Joel Jaeggli (joelja@uoregon.edu)
GPG Key Fingerprint:
5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2
