Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290841AbSBFWNf>; Wed, 6 Feb 2002 17:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290852AbSBFWNZ>; Wed, 6 Feb 2002 17:13:25 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:7105 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S290843AbSBFWNS>;
	Wed, 6 Feb 2002 17:13:18 -0500
Date: Wed, 06 Feb 2002 22:13:12 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Christoph Rohland <cr@sap.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andries.Brouwer@cwi.nl, hpa@zytor.com, linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: How to check the kernel compile options ?
Message-ID: <2093568702.1013033591@[195.224.237.69]>
In-Reply-To: <m3zo2meiea.fsf@linux.local>
In-Reply-To: <m3zo2meiea.fsf@linux.local>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, 06 February, 2002 4:31 PM +0100 Christoph Rohland 
<cr@sap.com> wrote:

> Not a symlink, but the implementation. We could make a generic
> interface something like proc_make_info_file(name, buffer, length).

& perhaps even on kernel load go through each appropriately
tagged elf section and just add it. That way the make process
could add (possibly distribution specific) files to the kernel
image /OR NOT ADD ANY/ without changes to the 'real' code.

--
Alex Bligh
