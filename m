Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbUK2XDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbUK2XDt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 18:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUK2XAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 18:00:21 -0500
Received: from smtp.e7even.com ([83.151.192.5]:55753 "HELO smtp.e7even.com")
	by vger.kernel.org with SMTP id S261869AbUK2W7o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:59:44 -0500
Message-ID: <41ABA9D3.7020602@st-andrews.ac.uk>
Date: Mon, 29 Nov 2004 22:59:31 +0000
From: Peter Foldiak <Peter.Foldiak@st-andrews.ac.uk>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Hans Reiser <reiser@namesys.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: file as a directory
References: <200411292120.iATLKZxE004233@laptop11.inf.utfsm.cl>
In-Reply-To: <200411292120.iATLKZxE004233@laptop11.inf.utfsm.cl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Now think about files with other formats, for instance the (in)famous
>sendmail.cf, or less structured stuff like you find in /etc/init.d/, or
>just Postgres databases (with fun stuff like permissions on records and
>fields)... or just people groping in /etc/passwd wanting to find the whole
>entry (not just one field), or perhaps look at the 15th character of the
>entry for John Doe.
>
>This way lies utter madness (what format description should be applied to
>what file this time around?). Plus shove all this garbage into the kernel?!
>  
>

I was suggesting this idea mainly form XML files, where the tags define 
the parts clearly.
In addition, I was suggesting that some of the XPath syntax (normally 
used for within-XML selection) could be extended above the file level 
into the file system.
The problems you mention are all related to non-XML file format issues, 
which was only a minor comment in parenthesis in my original mail. I am 
happy to do it only for XML to begin with (and if possible later see if 
it can be done for SOME non-XML formats).  Peter
