Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313820AbSDIIYV>; Tue, 9 Apr 2002 04:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313821AbSDIIYU>; Tue, 9 Apr 2002 04:24:20 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:46086 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313820AbSDIIYU>; Tue, 9 Apr 2002 04:24:20 -0400
Message-Id: <200204090821.g398LjX01722@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Event logging vs enhancing printk
Date: Tue, 9 Apr 2002 11:24:58 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Tony.P.Lee@nokia.com, kessler@us.ibm.com
In-Reply-To: <87960000.1018307908@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 April 2002 21:18, Martin J. Bligh wrote:

[snip]

> where printk_evlog calls printk_raw, then logs an "enhanced" version of
> the printk message to the *event logging* subsystem (not
> /var/log/messages), including process PID (0 or -1 if in_interrupt() ),
> file, line number, function, cpu number, accurate time stamp, etc, etc.

[snip]

As I understand, Linus accepts new features only if they are improving kernel 
in some vital area significantly (for example, Ingo's new scheduler).

If he has a feeling that existing subsystem is adequate, he is unlikely to
take replacements and intrusive enhancements (example: kbuild 2.5).
Something along the lines "it is does not broke _enough_, don't rewrite it".

(that's only IMHO, Linus didn't say it AFAIK)

You'll need to show that "enhanced" printk/evlog is significant improvement 
and is worth the trouble. That won't be easy.

That said, I wish you luck.
--
vda
