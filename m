Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311422AbSCSQd5>; Tue, 19 Mar 2002 11:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311424AbSCSQds>; Tue, 19 Mar 2002 11:33:48 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:14088 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S311422AbSCSQdh>; Tue, 19 Mar 2002 11:33:37 -0500
Date: Tue, 19 Mar 2002 13:41:36 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: chiranjeevi vaka <cvaka_kernel@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: using kmalloc
Message-ID: <20020319164136.GN20602@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	chiranjeevi vaka <cvaka_kernel@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020319161831.80877.qmail@web21306.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 19, 2002 at 08:18:31AM -0800, chiranjeevi vaka escreveu:

> I am getting some problems with kmalloc. If I tried to allocate more than
> certain memory then the system is hanging while booting with the changed
> kernel. Can you suggest me how to come out this situation. Can't I allocate
> as much I want when I want to allocate in the kernel. 

try vmalloc, kmalloc is limited, AFAIK, to 128 KiB and even that is difficult
to get after some time.

- Arnaldo
