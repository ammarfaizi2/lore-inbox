Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTDUIZp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 04:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbTDUIZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 04:25:45 -0400
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:53253 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id S263788AbTDUIZo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 04:25:44 -0400
Message-Id: <200304210829.h3L8Spu07199@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Date: Mon, 21 Apr 2003 11:37:00 +0300
X-Mailer: KMail [version 1.3.2]
References: <20030419180421.0f59e75b.skraw@ithnet.com> <20030419200712.3c48a791.skraw@ithnet.com> <20030419184120.GH669@gallifrey>
In-Reply-To: <20030419184120.GH669@gallifrey>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 April 2003 21:41, Dr. David Alan Gilbert wrote:
> Hi,
>   Besides the problem that most drive manufacturers now seem to use
> cheese as the data storage surface, I think there are some other
> problems:
>
>  1) I don't trust drive firmware.
>        2) I don't think all drives are set to remap sectors by default.
>        3) I don't believe that all drivers recover neatly from a drive error.
>        4) It is OK saying return the drive and get a new one - but many of
>           us can't do this in a commercial environment where the contents of
>                 the drive are confidential - leading to stacks of dead drives
>                 (often many inside their now short warranty periods).

And sadly,

   2) I don't trust Linux (driver + fs)
      will react adequately to disk errors.

Drive failures aren't that frequent, and relevant code paths
doomed to stay rarely tested (unless we put 0.00001% 'faked'
failures there ;)
--
vda
