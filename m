Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031223AbWKUWfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031223AbWKUWfn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031241AbWKUWfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:35:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:47004 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031223AbWKUWfn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:35:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=ggDDlKq5OVwnfywnTtogPsTgE2lYPS7PO2XTL5VEk1eV5l+vS5s29dnigSJms06Lqwmk0h+18uJVRYmTouMMlWQZpnnF8n9MrLnkd3HoOCmPXZRshnyFNC3K3jqoBKKTXG+vwWcPK18pvJjQp90t+taXz9NYM/QA2gJGEyLCLbw=
Message-ID: <45637F7E.80909@gmail.com>
Date: Tue, 21 Nov 2006 23:36:46 +0100
From: jan sonnek <xsonnek@gmail.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: jketreno@linux.intel.com
CC: linux-kernel@vger.kernel.org
Subject: Wifi driver ipw3945 disappear connecting with access point 
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, how does the pathes for driver looks like? My bug is.

In my notebook asus, I use wifi card ipw3945 and I have installed driver version
ipw3945-linux-1.1.0, downloaded from intel home page. I use Fedora core 6 and I


have also installed ieee80211-1.2.15. I connect to acces point and when I begin
to downloading some file or sometimes my connection disapper and in a one/two
seccond I connected it again. Here is 3 iwconfig status before signal disapper


and after, the Invalid misc is increasing: 

eth1      unassociated  ESSID:off/any  
          Mode:Managed  Frequency=2.442 GHz  Access Point: Not-Associated   
          Bit Rate:0 kb/s   Tx-Power:16 dBm   


          Retry limit:15   RTS thr:off   Fragment thr:off
          Encryption key:off
          Power Management:off
          Link Quality:0  Signal level:0  Noise level:0
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0


          Tx excessive retries:0  Invalid misc:3358   Missed beacon:0

sit0      no wireless extensions.

[root@wired-198 xsonnek]# iwconfig 
lo        no wireless extensions.

eth0      no wireless extensions.



eth1      IEEE 802.11b  ESSID:"wlan_fi"  
          Mode:Managed  Frequency:2.442 GHz  Access Point: 00:02:2D:1B:43:13   
          Bit Rate:11 Mb/s   Tx-Power:15 dBm   
          Retry limit:15   RTS thr:off   Fragment thr:off


          Encryption key:off
          Power Management:off
          Link Quality=77/100  Signal level=-57 dBm  Noise level=-58 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:3375   Missed beacon:0



sit0      no wireless extensions.

[root@wired-198 xsonnek]# iwconfig 
lo        no wireless extensions.

eth0      no wireless extensions.

eth1      IEEE 802.11b  ESSID:"wlan_fi"  


          Mode:Managed  Frequency:2.442 GHz  Access Point: 00:02:2D:1B:43:13   
          Bit Rate:11 Mb/s   Tx-Power:15 dBm   
          Retry limit:15   RTS thr:off   Fragment thr:off
          Encryption key:off


          Power Management:off
          Link Quality=77/100  Signal level=-57 dBm  Noise level=-58 dBm
          Rx invalid nwid:0  Rx invalid crypt:0  Rx invalid frag:0
          Tx excessive retries:0  Invalid misc:3382   Misse




Many Thanks, Jan Sonnek

