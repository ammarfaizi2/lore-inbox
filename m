Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130000AbQLTA4R>; Tue, 19 Dec 2000 19:56:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130021AbQLTA4H>; Tue, 19 Dec 2000 19:56:07 -0500
Received: from mail18.scannet.dk ([194.255.42.18]:32517 "HELO
	mail18.scannet.dk") by vger.kernel.org with SMTP id <S130000AbQLTAz6> convert rfc822-to-8bit;
	Tue, 19 Dec 2000 19:55:58 -0500
From: Jesper Juhl <juhl@eisenstein.dk>
Date: Tue, 19 Dec 2000 15:31:13 GMT
Message-ID: <20001219.15311300@jju.hyggekrogen.dk>
Subject: Platform string wrong for AlphaServer 400 4/233
To: linux-kernel@vger.kernel.org
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.2;Linux)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is a minor issue, but I thought I'd report it anyway.

When I do a 

# cat /proc/cpuinfo

on my AlphaServer 400 4/233 I get the following (IMHO wrong) output:

cpu                     : Alpha
cpu model               : EV45
cpu variation           : 7
cpu revision            : 0
cpu serial number       :
system type             : Avanti
system variation        : 0
system revision         : 0
system serial number    :
cycle frequency [Hz]    : 233334892 est.
timer frequency [Hz]    : 1024.00
page size [bytes]       : 8192
phys. address bits      : 34
max. addr. space #      : 63
BogoMIPS                : 229.11
kernel unaligned acc    : 0 (pc=0,va=0)
user unaligned acc      : 0 (pc=0,va=0)
platform string         : AlphaStation 400 4/233
cpus detected           : 1                                               
                    


The problem is that the 'Platform string' is set to 'AlphaStation 400 
4/233' when this machine is quite clearly (it's printed on it) a 
'AlphaServer 400 4/233' ( It is this machine: 
http://www5.compaq.com/alphaserver/archive/400/alphaserver400.html ).

It's nothing important, and it runs Linux just fine. Just thought it 
would be nice to see it fixed (if it is at all possible to tell the two 
different systems apart from the kernels point of view).


Best regards,
Jesper Juhl
juhl@eisenstein.dk


PS. Please CC all replies to me as I am not subscribed to the list.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
