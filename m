Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271268AbTGPXeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271265AbTGPXdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:33:40 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:28907 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S271315AbTGPXbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:31:38 -0400
Message-ID: <3F15E3C9.4030401@blue-labs.org>
Date: Wed, 16 Jul 2003 19:46:17 -0400
From: David Ford <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 sound drivers?
References: <20030716225826.GP2412@rdlg.net> <20030716231029.GG1821@matchmail.com> <20030716233045.GR2412@rdlg.net>
In-Reply-To: <20030716233045.GR2412@rdlg.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/dev/sound/* is from OSS.  You'll have to enable OSS emulation if you 
want legacy apps to be able to use your sound.

Alternatively, mpg123 --stdout | aplay, or similar.  Use a script or 
alias to make it easy on yourself.

David

Robert L. Harris wrote:

>I do but the problem is I don't have a /dev/dsp, /dev/sound/dsp or
>anything else to point mpg123 at.
>
>Thus spake Mike Fedyk (mfedyk@matchmail.com):
>
>  
>
>>On Wed, Jul 16, 2003 at 06:58:26PM -0400, Robert L. Harris wrote:
>>    
>>
>>>I have a soundblaster Live.  I've historically used the OSS drivers as
>>>they've worked well for me.  I just tried to load the emu10k1 which
>>>loads without error, but mpg123 says it can't open the default sound
>>>device.
>>>
>>>Anyone able to do an lsmod or a listing of the drivers I need for an
>>>SBLive?
>>>      
>>>
>>Did you install alsa-utils?
>>
>

