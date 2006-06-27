Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbWF0SRs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbWF0SRs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 14:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161251AbWF0SRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 14:17:47 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:63168 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S1161248AbWF0SRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 14:17:43 -0400
From: Foli Ayivoh <it21@arcor.de>
Reply-To: 101551.753@compuserve.com
To: lkml <linux-kernel@vger.kernel.org>
Subject: Problems with [USB] on Kernel 2.6.x [3/3]
Date: Tue, 27 Jun 2006 20:19:34 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200606272019.35205.it21@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lsusb -vvv

Bus 003 Device 006: ID 1038:0100 Ideazon, Inc. Zboard
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x1038 Ideazon, Inc.
  idProduct          0x0100 Zboard
  bcdDevice           10.98
  iManufacturer           1 Ideazon
  iProduct                2 Zboard
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          4 HID Keyboard
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              5 EP1 Int
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      64
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              6 EP2 Int
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.10
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength     108
          Report Descriptor: (length is 108)
            Item(Global): Usage Page, data= [ 0x0c ] 12
                            Consumer
            Item(Local ): Usage, data= [ 0x01 ] 1
                            Consumer Control
            Item(Main  ): Collection, data= [ 0x01 ] 1
                            Application
            Item(Global): Logical Minimum, data= [ 0x00 ] 0
            Item(Global): Logical Maximum, data= [ 0x01 ] 1
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x01 ] 1
            Item(Local ): Usage, data= [ 0xb8 ] 184
                            Eject
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0xe9 ] 233
                            Volume Increment
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0xea ] 234
                            Volume Decrement
            Item(Main  ): Input, data= [ 0x02 ] 2
                            Data Variable Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0xe2 ] 226
                            Mute
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0xcd ] 205
                            Play/Pause
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0xb5 ] 181
                            Scan Next Track
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0xb6 ] 182
                            Scan Previous Track
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x94 0x01 ] 404
                            AL Local Machine Browser
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x92 0x01 ] 402
                            AL Calculator
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0xb7 ] 183
                            Stop
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x96 0x01 ] 406
                            AL Internet Browser
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x8a 0x01 ] 394
                            AL Email Reader
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x85 0x01 ] 389
                            AL Text Editor
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x99 0x01 ] 409
                            AL Network Chat
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x1f 0x02 ] 543
                            AC Find
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x8b 0x01 ] 395
                            AL Newsreader
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Local ): Usage, data= [ 0x81 0x01 ] 385
                            AL Launch Button Configuration Tool
            Item(Main  ): Input, data= [ 0x06 ] 6
                            Data Variable Relative No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Report Size, data= [ 0x2f ] 47
            Item(Main  ): Input, data= [ 0x01 ] 1
                            Constant Array Absolute No_Wrap Linear
                            Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Usage Page, data= [ 0x08 ] 8
                            LEDs
            Item(Local ): Usage, data= [ 0x4b ] 75
                            Generic Indicator
            Item(Global): Report Size, data= [ 0x01 ] 1
            Item(Global): Report Count, data= [ 0x40 ] 64
            Item(Main  ): Output, data= [ 0x20 ] 32
                            Data Array Absolute No_Wrap Linear
                            No_Preferred_State No_Null_Position Non_Volatile Bitfield
            Item(Main  ): End Collection, data=none
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
Device Status:     0x0002
  (Bus Powered)
  Remote Wakeup Enabled

Bus 003 Device 005: ID 054c:00b0 Sony Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        16
  idVendor           0x054c Sony Corp.
  idProduct          0x00b0 
  bcdDevice            1.00
  iManufacturer           1 Sony
  iProduct                2 MPF-MSRW1
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      5 SFF-8070i
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               1
Device Status:     0x0000
  (Bus Powered)

Bus 003 Device 004: ID 054c:002c Sony Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x054c Sony Corp.
  idProduct          0x002c 
  bcdDevice            5.01
  iManufacturer           1 Sony
  iProduct                2 USB Floppy Drive
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           39
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      4 Floppy (UFI)
      bInterfaceProtocol      0 Control/Bulk/Interrupt
      iInterface              4 FLOPPY
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval              16
Device Status:     0x0000
  (Bus Powered)

Bus 003 Device 003: ID 03eb:3301 Atmel Corp. at43301 4-port Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x03eb Atmel Corp.
  idProduct          0x3301 at43301 4-port Hub
  bcdDevice            3.00
  iManufacturer           0 
  iProduct                2 Standard USB Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4 Standard USB Hub
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower               64mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              5 Standard USB Hub
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             4
  wHubCharacteristic 0x0000
    Ganged power switching
    Ganged overcurrent protection
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent     64 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x1e
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0303 lowspeed power enable connect
Device Status:     0x0000
  (Bus Powered)

Bus 003 Device 002: ID 0451:2036 Texas Instruments, Inc. TUSB2036 Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0451 Texas Instruments, Inc.
  idProduct          0x2036 TUSB2036 Hub
  bcdDevice            1.01
  iManufacturer           0 
  iProduct                1 General Purpose USB Hub
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          1 General Purpose USB Hub
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              1 General Purpose USB Hub
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             2
  wHubCharacteristic 0x0004
    Ganged power switching
    Compound device
    Ganged overcurrent protection
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent    100 milli Ampere
  DeviceRemovable    0x06
  PortPwrCtrlMask    0x06
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0103 power enable connect
Device Status:     0x0001
  Self Powered

Bus 003 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.17-mm3-default ohci_hcd
  iProduct                2 OHCI Host Controller
  iSerial                 1 0000:00:02.1
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             3
  wHubCharacteristic 0x0002
    No power switching (usb 1.0)
    Ganged overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0103 power enable connect
   Port 3: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

Bus 002 Device 057: ID 046a:0023 Cherry GmbH Cymotion Master Linux Keyboard
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x046a Cherry GmbH
  idProduct          0x0023 Cymotion Master Linux Keyboard
  bcdDevice            0.27
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           59
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      1 Keyboard
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      64
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      0 No Subclass
      bInterfaceProtocol      0 None
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      52
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0003  1x 3 bytes
        bInterval              10
Device Status:     0x0001
  Self Powered

Bus 002 Device 004: ID 046d:c50e Logitech, Inc. MX-1000 Cordless Mouse Receiver
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc50e MX-1000 Cordless Mouse Receiver
  bcdDevice           25.00
  iManufacturer           1 Logitech
  iProduct                2 USB Receiver
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           34
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower               70mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Devices
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0 
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      93
         Report Descriptors: 
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)

Bus 002 Device 002: ID 0557:7000 ATEN International Co., Ltd 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0557 ATEN International Co., Ltd
  idProduct          0x7000 
  bcdDevice            1.00
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              200mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             4
  wHubCharacteristic 0x0009
    Per-port power switching
    Per-port overcurrent protection
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent    100 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0x1e
 Hub Port Status:
   Port 1: 0000.0303 lowspeed power enable connect
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0303 lowspeed power enable connect
Device Status:     0x0001
  Self Powered

Bus 002 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.17-mm3-default ohci_hcd
  iProduct                2 OHCI Host Controller
  iSerial                 1 0000:00:02.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval             255
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             3
  wHubCharacteristic 0x0002
    No power switching (usb 1.0)
    Ganged overcurrent protection
  bPwrOn2PwrGood        1 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0103 power enable connect
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled

Bus 001 Device 006: ID 04b4:6830 Cypress Semiconductor Corp. USB-2.0 IDE Adapter
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x04b4 Cypress Semiconductor Corp.
  idProduct          0x6830 USB-2.0 IDE Adapter
  bcdDevice            0.01
  iManufacturer          56  
  iProduct               58  
  iSerial                60 D
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x86  EP 6 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               0
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0001
  Self Powered

Bus 001 Device 003: ID 050d:0237 Belkin Components 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x050d Belkin Components
  idProduct          0x0237 
  bcdDevice            1.00
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             7
  wHubCharacteristic 0x00a9
    Per-port power switching
    Per-port overcurrent protection
    TT think time 16 FS bits
    Port indicators
  bPwrOn2PwrGood        0 * 2 milli seconds
  bHubContrCurrent    100 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0100 power
   Port 7: 0000.0503 highspeed power enable connect
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0001
  Self Powered

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 Unused
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            2.06
  iManufacturer           3 Linux 2.6.17-mm3-default ehci_hcd
  iProduct                2 EHCI Host Controller
  iSerial                 1 0000:00:02.2
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 Unused
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             6
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0000
   Port 2: 0000.0503 highspeed power enable connect
   Port 3: 0000.0000
   Port 4: 0000.0000
   Port 5: 0000.0100 power
   Port 6: 0000.0100 power
Device Status:     0x0003
  Self Powered
  Remote Wakeup Enabled
