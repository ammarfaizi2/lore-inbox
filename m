Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291887AbSBASAr>; Fri, 1 Feb 2002 13:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291891AbSBASAh>; Fri, 1 Feb 2002 13:00:37 -0500
Received: from logic.net ([64.81.146.141]:20612 "EHLO logic.net")
	by vger.kernel.org with ESMTP id <S291887AbSBASAV>;
	Fri, 1 Feb 2002 13:00:21 -0500
Subject: Re: Linux 2.4.18pre7-ac2
From: "Edward S. Marshall" <esm@logic.net>
To: linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E16WQrT-0003YZ-00@the-village.bc.nu>
In-Reply-To: <E16WQrT-0003YZ-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 01 Feb 2002 11:59:15 -0600
Message-Id: <1012586357.1824.54.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-31 at 17:43, Alan Cox wrote:
> I've not had any patches for it nor anyone from Intel send me a card and a 
> bag of used notes 8). Intel did a chunk of the i2o work so its worth
> dropping their maintainer a note.

Not that it helps other than a slight data point, but I was seeing the
same problem with an HP NetRAID controller (based on MegaRAID) which
exhibited the same problems when in i2o emulation. Switching to mass
storage emulation fixed the issue.

http://sdb.suse.de/en/sdb/html/i2o_megaraid.html
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=55448

According to Arjen, the controller's i2o emulation is half-assed. ;-)

-- 
Edward S. Marshall <esm@logic.net>                       
http://esm.logic.net/
-------------------------------------------------------------------------------
[                  Felix qui potuit rerum cognoscere causas.            
]

