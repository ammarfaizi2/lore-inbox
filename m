Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288676AbSADPn5>; Fri, 4 Jan 2002 10:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288675AbSADPnh>; Fri, 4 Jan 2002 10:43:37 -0500
Received: from mailbox.egenera.com ([208.51.147.22]:13578 "EHLO
	mailbox.egenera.com") by vger.kernel.org with ESMTP
	id <S288674AbSADPn3>; Fri, 4 Jan 2002 10:43:29 -0500
Message-ID: <3C35CC16.3030408@egenera.com>
Date: Fri, 04 Jan 2002 10:36:54 -0500
From: "Patrick O'Rourke" <porourke@egenera.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Simon Turvey <turveysp@ntlworld.com>
CC: "SATHISH.J" <sathish.j@tatainfotech.com>,
        kernelnewbies <kernelnewbies@nl.linux.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to take a crash dump
In-Reply-To: <Pine.LNX.4.10.10201041427001.2221-100000@blrmail> <001e01c19508$ee319b70$140ba8c0@mistral>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Turvey wrote:

>>I have "lcrash" installed on my system. I have 2.4.8 kernel. I would like

>>to know how to make a linux system panic so that I can take a crash dump
>>and analyse using "lcrash". Is there any command to make the system panis
>>as we have on other unices(SVR4 and unixware)?


You can use Mission Critical Linux's crash dump analyser (aka crash) on
a live system and force it to panic via the "sys -panic" command.

The lkcd patch also adds an "alt-sysrq c" command that will force a dump.

Pat

-- 
Patrick O'Rourke
porourke@egenera.com

