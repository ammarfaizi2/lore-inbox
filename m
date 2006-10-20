Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423329AbWJTW5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423329AbWJTW5E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423328AbWJTW5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:57:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:44593 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423329AbWJTW5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:57:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=ImdNK9am7S75DGdDbRR9AwQo5jKALyc9E3pW4/agVmtSEZiH+I+daOjWeItTCmfuGJfq9msFg9QrswOZLF0XPP95ZS3+xyGJJP7oc+uHKjphvzLUWz1+/jxAcImV1f/pmNvRDeRJhRl2k9HSITz7EIqyEdVZcWcuGEEFyZ4WgdQ=
Message-ID: <45395451.6090302@gmail.com>
Date: Sat, 21 Oct 2006 00:56:58 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/1] Char: mxsers, correct tty driver name
References: <3160912811766612133@muni.cz> <20061019150212.6c95f6bf.akpm@osdl.org>
In-Reply-To: <20061019150212.6c95f6bf.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 19 Oct 2006 16:10:10 +0200
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> Mxser tty driver name should be ttyMI, not ttyM. Correct this in both
>> drivers (mxser, mxser_new) to avoid conflicts with isicom driver, which is
>> ttyM.
> 
> Is the mxser.c part needed in mainline?

Anybody more responsible doesn't tell anything; I say "no", but it may be
irrelevant.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
