Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287802AbSAAKbR>; Tue, 1 Jan 2002 05:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287801AbSAAKbK>; Tue, 1 Jan 2002 05:31:10 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:14287 "EHLO
	phalynx") by vger.kernel.org with ESMTP id <S287798AbSAAKax>;
	Tue, 1 Jan 2002 05:30:53 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Why would a valid DVD show zero files on Linux?
Date: Tue, 1 Jan 2002 02:30:38 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16LLuC-00089s-00@the-village.bc.nu>
In-Reply-To: <E16LLuC-00089s-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16LMBq-0007Lw-00@phalynx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 1, 2002 02:12, Alan Cox wrote:
> Now you've made the behaviour effectively random which is even worse. On
> a standard DVD the two file systems are the same. Some copy protected CD's
> have a UDF file system on them that isnt interesting. Some DVD's have an
> ISO fs that isnt interesting.

It seems like it should be up to userspace to first try UDF for DVDs, and 
first try iso9660 for CDs.

-Ryan
