Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313750AbSDIBMy>; Mon, 8 Apr 2002 21:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313809AbSDIBMx>; Mon, 8 Apr 2002 21:12:53 -0400
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:27039 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S313750AbSDIBMw>; Mon, 8 Apr 2002 21:12:52 -0400
Subject: Re: system call for finding the number of cpus??
From: Nicholas Miell <nmiell@attbi.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Davide Libenzi <davidel@xmailserver.org>,
        "Kuppuswamy, " Priyadarshini <Priyadarshini.Kuppuswamy@compaq.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020408215814.GC13043@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 08 Apr 2002 18:12:41 -0700
Message-Id: <1018314763.1714.4.camel@entropy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-04-08 at 14:58, J.A. Magallon wrote:
> >sysconf(_SC_NPROCESSORS_CONF);
> >
> 
> I din't really trusted you, so digged inside includes till bits/confname.h
> Why the h*ll the manpage about sysconf does not talk about that ?????
> 

For some odd reason, the FSF doesn't like man pages. If you read the
info documentation for glibc, you'll find the _SC_NPROCESSORS_CONF
property listed in the "libc : System Configuration : Sysconf :
Constants for Sysconf" page. The man pages tend to lag behind the actual
info documentation, because they are maintained seperately.

