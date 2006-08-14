Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWHNVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWHNVeO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWHNVeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:34:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:6466 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S964939AbWHNVeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:34:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=E7wZW6sF4XfXvPiZ/Id5L/UB/xDlLxJA5+RXzdcsvzyrg8byUEgHSRjo3hZ1R2TznubGl/O0m9Bhbu7XJ6JmIzccaeO3OL4KhWi+vRjMzlU5SCru0Xgsv/CY91sZaJhrrjS8YTkEgijyrfrzK+JqPQtVuMYhaFtAwD3ef5kkTts=
Message-ID: <44E0EC66.80105@gmail.com>
Date: Mon, 14 Aug 2006 23:34:07 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Hulin Thibaud <hulin.thibaud@wanadoo.fr>
CC: linux-kernel@vger.kernel.org, darkhack@gmail.com, reinaldoc@gmail.com
Subject: Re: kernel panic - not syncing: VFS - unable to mount root fs on
 unknown-block
References: <44DFCF20.9030202@wanadoo.fr> <44E07B36.6070508@gmail.com> <44E08C50.5070904@wanadoo.fr> <44E0E800.1050000@wanadoo.fr>
In-Reply-To: <44E0E800.1050000@wanadoo.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hulin Thibaud wrote:
> In progress ! I built-in LVM driver and compile the kernel with the 
> -initrd option. I have not more the kernel panic message, but I have a 
> lot of errors than this :
> 
> I/O error ; hda: cannot handle device with more than 16 heads - giving up

Try to kick off
Use old disk-only driver on primary interface
at
-> Device Drivers 

   -> ATA/ATAPI/MFM/RLL support 

     -> ATA/ATAPI/MFM/RLL support (IDE [=y]) 

       -> Enhanced IDE/MFM/RLL disk/cdrom/tape/floppy support (BLK_DEV_IDE [=y]) 


regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
