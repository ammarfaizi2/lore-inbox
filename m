Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261591AbRESWFt>; Sat, 19 May 2001 18:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261769AbRESWFj>; Sat, 19 May 2001 18:05:39 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:58539 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S261591AbRESWFd>;
	Sat, 19 May 2001 18:05:33 -0400
Message-ID: <3B06EE28.157D327C@mandrakesoft.com>
Date: Sat, 19 May 2001 18:05:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.4-ac11 aironet fixes
In-Reply-To: <200105192142.XAA02267@green.mif.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch looks generally ok.

Comments:
* you forgot to cc Elmer Joandi, the maintainer, who wakes up every now
and then :)
* When is aironet4500_card version string printed, for the modular case?
* did you actually trace the code paths to mark sure code marked __init
was never called by the pcmcia hotplug part of the code?  I just want to
make sure you didn't mark them __init due to an assumption based on
function name.

-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
