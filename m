Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbREVRph>; Tue, 22 May 2001 13:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262688AbREVRp1>; Tue, 22 May 2001 13:45:27 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:39833 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262687AbREVRpU>;
	Tue, 22 May 2001 13:45:20 -0400
Message-ID: <3B0AA5A5.A417FF7B@mandrakesoft.com>
Date: Tue, 22 May 2001 13:45:09 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcus Meissner <Marcus.Meissner@caldera.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: more esssolo1 cleanups
In-Reply-To: <20010522144438.A21170@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks ok.  General comment:  the code to search through the list of PCI
devices and drivers to find the one associated with our minor should be
in a separate function, if that code appears more than once. 
esssolo_find_minor or somesuch...

-- 
Jeff Garzik      | "Are you the police?"
Building 1024    | "No, ma'am.  We're musicians."
MandrakeSoft     |
