Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263134AbTCSU0b>; Wed, 19 Mar 2003 15:26:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263142AbTCSU0a>; Wed, 19 Mar 2003 15:26:30 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:62955 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id <S263134AbTCSU03>;
	Wed, 19 Mar 2003 15:26:29 -0500
From: wind@cocodriloo.com
Date: Wed, 19 Mar 2003 21:39:12 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Deprecating .gz format on kernel.org
Message-ID: <20030319203912.GA21912@wind.cocodriloo.com>
References: <3E78D0DE.307@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E78D0DE.307@zytor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 19, 2003 at 12:19:42PM -0800, H. Peter Anvin wrote:
> Hello everyone,
> 
> At some point it probably would make sense to start deprecating .gz
> format files from kernel.org.
> 
> I am envisioning this as a three-phase changeover:
> 
> a) Get all mirrors to carry .bz2 format.  This would affect the
> following sites:
> 
> DUTH:format=gz
> GARBO:format=gz
> HCMC:format=gz
> IGLU:format=gz
> LINUXAID:format=gz
> LLARIAN-NET:format=gz
> MINET-FR:format=gz
> NC-ORC:format=gz
> PCSS:format=gz
> PROGRAMVAREVERKSTEDET:format=gz
> PUB-FTP-UNIVERSITY-OF-OLDENBURG:format=gz
> RN-RNO:format=gz
> TASK:format=gz
> TELEPAC:format=gz
> TENGU-EASYNET-FR:format=gz
> UNC-METALAB:format=gz
> WEBLAB:format=gz
> 
> b) Once that is done, change the robots to no longer require .gz files;
> .bz2 files uploaded would be signed but no .gz file would be generated.
> 
> -> If we get a complete loss of data here, all .gz files would be lost.
> 
> c) At some point, deprecate .gz uploads entirely and remove all the old
> .gz files.  After that point .gz files uploaded would be treated just
> like .Z, .zip or any other "unmanaged" compression format.
> 
> 
> Now, the questions that come up are:
> 
> i) Does this sound reasonable to everyone?  In particular, is there any
> loss in losing the "original" compressed files?

I don't think phase three is really needed...

It sounds reasonable, but if it's mainly due to space consuption, I
think it would be nice to code a bzip2-to-gz cgi server so that there is
no loss on functionality. This would need CPU power, so perhaps
rate-limiting the sending side of the CGI would manage to keep
the CPU low on use.

> ii) Assuming a yes on the previous question, what time frame would it
> make sense for this changeover to happen over?

Don't know.

Greets anyways, Antonio.

