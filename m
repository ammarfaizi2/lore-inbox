Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281780AbRK0V16>; Tue, 27 Nov 2001 16:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282958AbRK0V1s>; Tue, 27 Nov 2001 16:27:48 -0500
Received: from ulima.unil.ch ([130.223.144.143]:3713 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S281780AbRK0V1n>;
	Tue, 27 Nov 2001 16:27:43 -0500
Date: Tue, 27 Nov 2001 22:27:38 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: Can't acess ide ZIP under 2.4.16 with devfs
Message-ID: <20011127222738.A15151@ulima.unil.ch>
In-Reply-To: <20011127202112.A13757@ulima.unil.ch> <3C03FEC5.3000003@paulbristow.net> <20011127221113.A14806@ulima.unil.ch> <20011127222042.C14806@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011127222042.C14806@ulima.unil.ch>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 10:20:42PM +0100, Gregoire Favre wrote:
> Hello,
> 
> I am also interested of any way I could access my ZIP having devfs, but
> I don't have anything against making a mknod or whatever needed...
> 
> Thanks you very much,

Oups, sorry for the posts:
sudo MAKEDEV -d /tmp/esa hdc
sudo mount -t ext3 /tmp/esa/hdc /mnt/ext2/

Works just great ;-)

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
