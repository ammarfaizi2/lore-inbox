Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbREPIvz>; Wed, 16 May 2001 04:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261839AbREPIvp>; Wed, 16 May 2001 04:51:45 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:48394 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261837AbREPIvg>; Wed, 16 May 2001 04:51:36 -0400
Message-ID: <3B023F77.D9FB50F2@idb.hist.no>
Date: Wed, 16 May 2001 10:51:03 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre2 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <20010515145830.Y5599@sventech.com> <Pine.LNX.4.21.0105151208540.2339-100000@penguin.transmeta.com> <20010515154325.Z5599@sventech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt wrote:

> I had always made the assumption that sockets were created because you
> couldn't easily map IPv4 semantics onto filesystems. It's unreasonable
> to have a file for every possible IP address/port you can communicate
> with.

You could have "open("/ipv4/127.0.0.1/80") without having pre-allocated
files and directories.  The "ipfs" driver would simply
accept any valid address without looking it up in any directory
structure.
Preallocation problems is no argument against a fs, in this
case tradition is.

Helge Hafting
