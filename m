Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRK0JwE>; Tue, 27 Nov 2001 04:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274789AbRK0Jvz>; Tue, 27 Nov 2001 04:51:55 -0500
Received: from dmb001.rug.ac.be ([157.193.78.1]:11955 "HELO dmb.rug.ac.be")
	by vger.kernel.org with SMTP id <S273588AbRK0Jvo>;
	Tue, 27 Nov 2001 04:51:44 -0500
Message-ID: <3C036245.6080105@dmb.rug.ac.be>
Date: Tue, 27 Nov 2001 10:52:05 +0100
From: Didier Moens <Didier.Moens@dmb001.rug.ac.be>
Organization: RUG/VIB - Dept. Molecular Biology
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Abraham vd Merwe <abraham@2d3d.co.za>
Cc: Nicolas Aspert <Nicolas.Aspert@epfl.ch>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        skraw@ithnet.com
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be> <3C022BB4.7080707@epfl.ch> <1006808870.817.0.camel@phantasy> <3C02BF41.1010303@xs4all.be> <20011127101148.C5778@crystal.2d3d.co.za> <3C034CAE.2090103@dmb.rug.ac.be> <20011127111022.B881@crystal.2d3d.co.za>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abraham vd Merwe wrote:


> Hi Didier!
> 
> I misunderstood. I thought you have an on-board 830M video card :P
> 
> So you have an 830M motherboard, with a Radeon display card?



Seems like I'm having some egg on my face here. Argh !

According to http://developer.intel.com/design/chipsets/mobile/830.htm :

830MP : supports external AGP2X/4X graphics
830M  : includes Intel's next generation performance oriented integrated 
graphics controller, featuring Intel® Graphics Technology, as well as 
external AGP2X/4X graphics support
830MG : supports value oriented integrated graphics for value priced 
notebook segments


To sum up : this is an IBM A30p, with an "external" Radeon Mobility LY 
(32 MB), and an 830MP instead of an 830M. The 830MP is common for both 
IBM A30 and A30p models.


Sorry about wasting your time this way : I should get my facts straight 
in the first place. I did have oopses, though.  ;)


No mention of the 830MP in the kernel sources ; patches are welcome.  :)




> If you have a Radeon display card and an 830M motherboard chipset, it might
> be that the agpgart module is trying to use the 830M display chipset code.
> that would definitely cause problems.




Regards,

Didier

