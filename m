Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932500AbWKGM1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWKGM1Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 07:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWKGM1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 07:27:24 -0500
Received: from wx-out-0506.google.com ([66.249.82.224]:8878 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932500AbWKGM1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 07:27:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=tWMUETrPrQrXoRaP6bJ3OIfEd7dR7Y9ldiPkJ0SW9LeSGdqQ0AzJFUPKmtQNggRNdG/Uq5IG1/sdQ1QRkMEQD2c0RyzoJJHyhpuWQLrwLYbkus6jSrQkvHOtPr4saRBGN65NahSz+fH2lRtQ8POr8Jk/aNz8fn9M/AdqXM/VJ64=
Message-ID: <45507BA3.9010700@kaigai.gr.jp>
Date: Tue, 07 Nov 2006 21:27:15 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       chris friedhoff <chris@friedhoff.org>,
       Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1] security: introduce file posix caps
References: <20061107034550.GA13693@sergelap.austin.ibm.com>
In-Reply-To: <20061107034550.GA13693@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Serge.

I packaged the xattr extension of libcap, get/setfcaps command and
manual pages with original libcap-1.10-25.
See, http://www.kaigai.gr.jp/index.php?FrontPage#b556e50d

You can download RPM and SRPM package for the latest FC6 system.
There are no difference at its functionality, but the part of xattr
extension is moved into /lib/libcap.so.1.

Thanks,

Serge E. Hallyn wrote:
> Implement file posix capabilities.  This allows programs to be given
> a subset of root's powers regardless of who runs them, without
> having to use setuid and giving the binary all of root's powers.
> 
> This version works with Kaigai Kohei's userspace tools, found at
> http://www.kaigai.gr.jp/pub/fscaps-1.0-kg.src.rpm under
> http://www.kaigai.gr.jp/index.php?FrontPage#b556e50d.
> 
> (For more information on how to use, Chris Friedhoff has posted a nice
> page on his use of file caps at http://www.friedhoff.org/fscaps.html.
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>
