Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSFEXON>; Wed, 5 Jun 2002 19:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSFEXOM>; Wed, 5 Jun 2002 19:14:12 -0400
Received: from jalon.able.es ([212.97.163.2]:2944 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316535AbSFEXOJ>;
	Wed, 5 Jun 2002 19:14:09 -0400
Date: Thu, 6 Jun 2002 01:12:45 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Oliver Wegner <oliver@wilmskamp.dyndns.org>, root@chaos.analogic.com,
        linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
Message-ID: <20020605231245.GA1804@werewolf.able.es>
In-Reply-To: <Pine.LNX.3.95.1020605172819.12226A-100000@chaos.analogic.com> <200206060023.42180.oliver@wilmskamp.dyndns.org> <1023320742.2443.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.06.06 Alan Cox wrote:
>On Wed, 2002-06-05 at 23:23, Oliver Wegner wrote:
>> all i wanted to point out was that it doesnt seem to be distribution 
>> independent as someone had stated before because that file /etc/modules 
>> for example doesnt exist under SuSE. i wasnt asking anything about it 
>> myself.
>> 
>> anyway i will be able to find out that information if i need to sometime. 
>> thanks.
>
>modules.conf is the standard name for it. A long time ago it was
>sometimes called conf.modules. 
>

Usually there is an rc script called /etc/rc.d/rc.modules. It
can load modules directly (perhaps this is the case on SuSE and RH),
or it reads the list of modules to load from an independent file
(/etc/modules in Mandrake, for example). In the first case you add
the 'modprobe xxxx' directly in the rc script, and in the second you
just add 'xxxx' in /etc/modules, so you do not modify a system file
and rpm is happy about .rpmnew files.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre10-jam1 #3 SMP jue jun 6 00:00:33 CEST 2002 i686
