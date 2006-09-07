Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751905AbWIGXnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbWIGXnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 19:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWIGXnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 19:43:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:60563 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751873AbWIGXnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 19:43:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bb35iJcFXBaCKt23q6mylB+jlMi25Y9TVmtmshFLpvpy4OokC5QgioJez+ZS7Kvba39tdf9Cb0i328rcF7bm2gpYzZmiRJTuLOdI6h0oI7V0cUg9+QsYN2Alq79YcZHnMCL1htvgKTmk76rBk0LSKxHjOnhRF5WIdmVGUO4HRmE=
Message-ID: <4500AE5B.1070808@gmail.com>
Date: Fri, 08 Sep 2006 01:42:19 +0200
From: Tim Okrongli <j6cubic@gmail.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org
Subject: Re: Panics on AMD X2/NVidiaMCP55Ultra
References: <fa.5Ci7uSCK5S3sGLcqEDBk92xuBGc@ifi.uio.no> <4500A8B5.7040305@shaw.ca>
In-Reply-To: <4500A8B5.7040305@shaw.ca>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Hancock wrote:
> With no symbols in the stack trace this is not very useful. Do you 
> have CONFIG_KALLSYMS enabled?
>
Argh, forgot to cc my reply to someone else's question to the ML. The 
problem could be traced to a faulty DIMM - by coincidence it was only 
used while fscking; even during an attempted kernel rebuild no problems 
arose (or rather: make ran into a different problem before it caused 
RAM-related problems). That's why it took me so long (more than three 
weeks and two mainboards, in fact) to figure out what it was.

For the sake of completeness, I found out when I finally resorted to 
installing Windows so I could at least test the GPU and the setup CD 
kept bluescreening.


Sorry to needlessly bother you.
